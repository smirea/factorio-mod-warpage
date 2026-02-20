#!/usr/bin/env node

import fs from "node:fs";
import path from "node:path";

const runtimeJsonPath =
  process.env.FACTORIO_RUNTIME_JSON ||
  "/Applications/factorio.app/Contents/doc-html/runtime-api.json";
const prototypeJsonPath =
  process.env.FACTORIO_PROTOTYPE_JSON ||
  "/Applications/factorio.app/Contents/doc-html/prototype-api.json";
const outputDir = process.env.FACTORIO_STUB_OUT_DIR || ".luals/factorio";

const runtimeDoc = readJson(runtimeJsonPath);
const prototypeDoc = readJson(prototypeJsonPath);

fs.mkdirSync(outputDir, { recursive: true });

const runtimeStubPath = path.join(outputDir, "runtime.generated.lua");
const prototypeStubPath = path.join(outputDir, "prototype.generated.lua");

const runtimeStub = generateRuntimeStub(runtimeDoc);
const prototypeStub = generatePrototypeStub(prototypeDoc, runtimeStub.declaredTypeNames);

fs.writeFileSync(runtimeStubPath, runtimeStub.content);
fs.writeFileSync(prototypeStubPath, prototypeStub);

console.log(`Generated: ${runtimeStubPath}`);
console.log(`Generated: ${prototypeStubPath}`);

function readJson(filePath) {
  if (!fs.existsSync(filePath)) {
    throw new Error(`JSON file not found: ${filePath}`);
  }

  const raw = fs.readFileSync(filePath, "utf8");
  return JSON.parse(raw);
}

function isIdentifier(name) {
  return /^[A-Za-z_][A-Za-z0-9_]*$/.test(name);
}

function sanitizeIdentifier(name, fallback = "value") {
  const normalized = String(name).replace(/[^A-Za-z0-9_]/g, "_");
  let value = normalized;
  if (!value || /^[0-9]/.test(value)) {
    value = `_${value}`;
  }

  if (!value || value === "_") {
    value = fallback;
  }

  return value;
}

function quoteLuaString(value) {
  return JSON.stringify(String(value));
}

function sortByOrder(items) {
  return [...(items || [])].sort((a, b) => {
    const orderA = typeof a.order === "number" ? a.order : 0;
    const orderB = typeof b.order === "number" ? b.order : 0;
    if (orderA !== orderB) {
      return orderA - orderB;
    }

    return String(a.name || "").localeCompare(String(b.name || ""));
  });
}

function dedupeStrings(values) {
  const seen = new Set();
  const result = [];
  for (const value of values) {
    if (!seen.has(value)) {
      seen.add(value);
      result.push(value);
    }
  }
  return result;
}

function mapPrimitiveType(name) {
  const numericIntegerTypes = new Set([
    "int8",
    "int16",
    "int32",
    "int64",
    "uint8",
    "uint16",
    "uint32",
    "uint64",
    "MapTick"
  ]);

  if (numericIntegerTypes.has(name)) {
    return "integer";
  }

  if (name === "float" || name === "double") {
    return "number";
  }

  if (name === "boolean" || name === "string" || name === "table" || name === "nil") {
    return name;
  }

  if (name === "Any" || name === "AnyBasic") {
    return "any";
  }

  if (name.startsWith("defines.")) {
    return "integer";
  }

  if (isIdentifier(name)) {
    return name;
  }

  return "any";
}

function joinUnion(parts) {
  const values = dedupeStrings(parts.filter(Boolean));
  if (values.length === 0) {
    return "any";
  }
  return values.join("|");
}

function wrapArrayElementType(typeName) {
  if (typeName.includes("|")) {
    return `(${typeName})`;
  }
  return typeName;
}

function inlineTableType(parameters) {
  if (!parameters || parameters.length === 0) {
    return "table";
  }

  const fields = [];
  for (const parameter of sortByOrder(parameters)) {
    if (!parameter || typeof parameter.name !== "string") {
      return "table";
    }

    if (!isIdentifier(parameter.name)) {
      return "table";
    }

    const typeName = toLuaType(parameter.type);
    if (parameter.optional === true) {
      fields.push(`${parameter.name}?: ${typeName}`);
    } else {
      fields.push(`${parameter.name}: ${typeName}`);
    }
  }

  if (fields.length === 0) {
    return "table";
  }

  return `{ ${fields.join(", ")} }`;
}

function toLuaType(typeSpec) {
  if (typeSpec == null) {
    return "any";
  }

  if (typeof typeSpec === "string") {
    return mapPrimitiveType(typeSpec);
  }

  if (typeof typeSpec !== "object") {
    return "any";
  }

  if (typeof typeSpec.type !== "undefined" && typeof typeSpec.complex_type === "undefined") {
    return toLuaType(typeSpec.type);
  }

  const complexType = typeSpec.complex_type;
  if (typeof complexType !== "string") {
    return "any";
  }

  if (complexType === "type") {
    return toLuaType(typeSpec.value);
  }

  if (complexType === "array") {
    return `${wrapArrayElementType(toLuaType(typeSpec.value))}[]`;
  }

  if (complexType === "dictionary" || complexType === "LuaCustomTable") {
    return `table<${toLuaType(typeSpec.key)}, ${toLuaType(typeSpec.value)}>`;
  }

  if (complexType === "union") {
    const options = typeSpec.options || [];
    const mapped = options.map((option) => {
      if (typeSpec.full_format === true && option && typeof option === "object" && "type" in option) {
        return toLuaType(option.type);
      }
      return toLuaType(option);
    });

    return joinUnion(mapped);
  }

  if (complexType === "literal") {
    const value = typeSpec.value;
    if (typeof value === "string") {
      return quoteLuaString(value);
    }

    if (typeof value === "number" || typeof value === "boolean") {
      return String(value);
    }

    return "any";
  }

  if (complexType === "function") {
    const parameterTypes = (typeSpec.parameters || []).map((parameter, index) => {
      return `p${index + 1}: ${toLuaType(parameter)}`;
    });

    return `fun(${parameterTypes.join(", ")})`;
  }

  if (complexType === "table") {
    return inlineTableType(typeSpec.parameters || []);
  }

  if (complexType === "LuaStruct") {
    const attributes = (typeSpec.attributes || []).map((attribute) => {
      if (!attribute || typeof attribute.name !== "string" || !isIdentifier(attribute.name)) {
        return null;
      }

      const typeName = toLuaType(attribute.read_type || attribute.write_type);
      if (attribute.optional === true) {
        return `${attribute.name}?: ${typeName}`;
      }

      return `${attribute.name}: ${typeName}`;
    });

    if (attributes.some((attribute) => attribute == null)) {
      return "table";
    }

    const fields = attributes.filter(Boolean);
    if (fields.length === 0) {
      return "table";
    }

    return `{ ${fields.join(", ")} }`;
  }

  if (complexType === "LuaLazyLoadedValue") {
    return toLuaType(typeSpec.value);
  }

  return "table";
}

function renderFieldAnnotation(fieldName, typeName) {
  if (isIdentifier(fieldName)) {
    return `---@field ${fieldName} ${typeName}`;
  }

  return `---@field [${quoteLuaString(fieldName)}] ${typeName}`;
}

function renderParamAnnotations(lines, parameters, parameterNames) {
  for (let index = 0; index < parameters.length; index += 1) {
    const parameter = parameters[index];
    let typeName = toLuaType(parameter.type);
    if (parameter.optional === true) {
      typeName = `${typeName}|nil`;
    }

    lines.push(`---@param ${parameterNames[index]} ${typeName}`);
  }
}

function renderReturnAnnotations(lines, returnValues) {
  if (!returnValues || returnValues.length === 0) {
    return;
  }

  const sortedReturnValues = sortByOrder(returnValues);
  const typeNames = sortedReturnValues.map((value) => {
    let typeName = toLuaType(value.type);
    if (value.optional === true) {
      typeName = `${typeName}|nil`;
    }
    return typeName;
  });

  lines.push(`---@return ${typeNames.join(", ")}`);
}

function methodFunctionType(method) {
  if (!method || typeof method.name !== "string" || !isIdentifier(method.name)) {
    return "fun(...)";
  }

  const format = method.format || { takes_table: false };
  const sortedParameters = sortByOrder(method.parameters || []);
  const args = [];

  if (format.takes_table === true) {
    let tableType = inlineTableType(sortedParameters);
    if (format.table_optional === true) {
      tableType = `${tableType}|nil`;
    }

    args.push(`params: ${tableType}`);
  } else {
    const seenNames = new Set();
    for (let index = 0; index < sortedParameters.length; index += 1) {
      const parameter = sortedParameters[index];
      const fallback = `param${index + 1}`;
      let parameterName = sanitizeIdentifier(parameter.name || fallback, fallback);
      if (seenNames.has(parameterName)) {
        parameterName = `${parameterName}_${index + 1}`;
      }

      seenNames.add(parameterName);

      let typeName = toLuaType(parameter.type);
      if (parameter.optional === true) {
        typeName = `${typeName}|nil`;
      }

      args.push(`${parameterName}: ${typeName}`);
    }
  }

  if (method.variadic_parameter && method.variadic_parameter.type) {
    args.push(`...: ${toLuaType(method.variadic_parameter.type)}`);
  }

  const returnValues = sortByOrder(method.return_values || []).map((value) => {
    let typeName = toLuaType(value.type);
    if (value.optional === true) {
      typeName = `${typeName}|nil`;
    }
    return typeName;
  });

  if (returnValues.length > 0) {
    return `fun(${args.join(", ")}): ${returnValues.join(", ")}`;
  }

  return `fun(${args.join(", ")})`;
}

function renderGlobalFunction(lines, method) {
  if (!method || typeof method.name !== "string" || !isIdentifier(method.name)) {
    return;
  }

  const format = method.format || { takes_table: false };
  const sortedParameters = sortByOrder(method.parameters || []);

  if (format.takes_table === true) {
    let tableType = inlineTableType(sortedParameters);
    if (format.table_optional === true) {
      tableType = `${tableType}|nil`;
    }

    lines.push(`---@param params ${tableType}`);
    renderReturnAnnotations(lines, method.return_values || []);
    lines.push(`function ${method.name}(params) end`);
    lines.push("");
    return;
  }

  const parameterNames = [];
  const seenNames = new Set();
  for (let index = 0; index < sortedParameters.length; index += 1) {
    const fallback = `param${index + 1}`;
    let parameterName = sanitizeIdentifier(sortedParameters[index].name || fallback, fallback);
    if (seenNames.has(parameterName)) {
      parameterName = `${parameterName}_${index + 1}`;
    }

    seenNames.add(parameterName);
    parameterNames.push(parameterName);
  }

  renderParamAnnotations(lines, sortedParameters, parameterNames);
  if (method.variadic_parameter && method.variadic_parameter.type) {
    lines.push(`---@param ... ${toLuaType(method.variadic_parameter.type)}`);
  }
  renderReturnAnnotations(lines, method.return_values || []);

  let signature = parameterNames.join(", ");
  if (method.variadic_parameter && method.variadic_parameter.type) {
    signature = signature ? `${signature}, ...` : "...";
  }

  lines.push(`function ${method.name}(${signature}) end`);
  lines.push("");
}

function renderClass(lines, classDef, declaredTypeNames) {
  if (!classDef || typeof classDef.name !== "string" || !isIdentifier(classDef.name)) {
    return;
  }

  let classHeader = `---@class ${classDef.name}`;
  if (classDef.parent && isIdentifier(classDef.parent)) {
    classHeader = `${classHeader}: ${classDef.parent}`;
  }

  lines.push(classHeader);

  for (const attribute of sortByOrder(classDef.attributes || [])) {
    const typeSpec = attribute.read_type || attribute.write_type;
    let typeName = toLuaType(typeSpec);
    if (attribute.optional === true) {
      typeName = `${typeName}|nil`;
    }

    lines.push(renderFieldAnnotation(attribute.name, typeName));
  }

  for (const method of sortByOrder(classDef.methods || [])) {
    lines.push(renderFieldAnnotation(method.name, methodFunctionType(method)));
  }

  lines.push("");

  declaredTypeNames.add(classDef.name);
}

function defineClassName(pathParts) {
  if (!pathParts || pathParts.length === 0) {
    return "defines";
  }

  return `defines_${pathParts.map((part) => sanitizeIdentifier(part)).join("_")}`;
}

function collectDefineNodes(node, pathParts, pathToClassName, usedClassNames) {
  const pathKey = pathParts.join(".");
  if (!pathToClassName.has(pathKey)) {
    const baseClassName = defineClassName(pathParts);
    let className = baseClassName;
    let suffix = 2;

    while (usedClassNames.has(className)) {
      className = `${baseClassName}_${suffix}`;
      suffix += 1;
    }

    usedClassNames.add(className);
    pathToClassName.set(pathKey, className);
  }

  for (const subkey of sortByOrder(node.subkeys || [])) {
    collectDefineNodes(subkey, [...pathParts, subkey.name], pathToClassName, usedClassNames);
  }
}

function renderDefineClasses(lines, topLevelDefines) {
  const root = { name: "defines", subkeys: topLevelDefines || [], values: [] };
  const pathToClassName = new Map();
  const usedClassNames = new Set();

  collectDefineNodes(root, [], pathToClassName, usedClassNames);

  const nodesByPath = new Map();
  function collect(node, pathParts) {
    const key = pathParts.join(".");
    nodesByPath.set(key, node);
    for (const subkey of sortByOrder(node.subkeys || [])) {
      collect(subkey, [...pathParts, subkey.name]);
    }
  }

  collect(root, []);

  const sortedPaths = [...nodesByPath.keys()].sort((a, b) => {
    const aDepth = a === "" ? 0 : a.split(".").length;
    const bDepth = b === "" ? 0 : b.split(".").length;
    if (aDepth !== bDepth) {
      return bDepth - aDepth;
    }

    return a.localeCompare(b);
  });

  for (const pathKey of sortedPaths) {
    const node = nodesByPath.get(pathKey);
    const className = pathToClassName.get(pathKey);

    lines.push(`---@class ${className}`);

    for (const subkey of sortByOrder(node.subkeys || [])) {
      const childPath = pathKey ? `${pathKey}.${subkey.name}` : subkey.name;
      const childClassName = pathToClassName.get(childPath);
      lines.push(renderFieldAnnotation(subkey.name, childClassName));
    }

    for (const value of sortByOrder(node.values || [])) {
      lines.push(renderFieldAnnotation(value.name, "integer"));
    }

    lines.push("");
  }

  lines.push("---@type defines");
  lines.push("defines = nil");
  lines.push("");
}

function generateRuntimeStub(runtime) {
  const lines = [];
  const declaredTypeNames = new Set();

  lines.push("---@meta");
  lines.push("");
  lines.push(`-- Generated from Factorio runtime JSON docs (${runtime.application_version}, api v${runtime.api_version}).`);
  lines.push("");

  const classNames = new Set((runtime.classes || []).map((classDef) => classDef.name).filter(isIdentifier));

  for (const concept of sortByOrder(runtime.concepts || [])) {
    if (!concept || typeof concept.name !== "string" || !isIdentifier(concept.name)) {
      continue;
    }

    if (classNames.has(concept.name)) {
      continue;
    }

    let aliasType = "any";
    if (concept.type === "builtin") {
      aliasType = "any";
    } else {
      aliasType = toLuaType(concept.type);
    }

    lines.push(`---@alias ${concept.name} ${aliasType}`);
    declaredTypeNames.add(concept.name);
  }

  lines.push("");

  for (const classDef of sortByOrder(runtime.classes || [])) {
    renderClass(lines, classDef, declaredTypeNames);
  }

  renderDefineClasses(lines, runtime.defines || []);

  for (const globalObject of sortByOrder(runtime.global_objects || [])) {
    if (!globalObject || typeof globalObject.name !== "string" || !isIdentifier(globalObject.name)) {
      continue;
    }

    lines.push(`---@type ${toLuaType(globalObject.type)}`);
    lines.push(`${globalObject.name} = nil`);
    lines.push("");
  }

  for (const globalFunction of sortByOrder(runtime.global_functions || [])) {
    renderGlobalFunction(lines, globalFunction);
  }

  return {
    content: lines.join("\n"),
    declaredTypeNames
  };
}

function renderPrototypeStructClass(lines, typeDef, declaredTypeNames) {
  if (!typeDef || typeof typeDef.name !== "string" || !isIdentifier(typeDef.name)) {
    return;
  }

  let classHeader = `---@class ${typeDef.name}`;
  if (typeDef.parent && isIdentifier(typeDef.parent)) {
    classHeader = `${classHeader}: ${typeDef.parent}`;
  }

  lines.push(classHeader);

  for (const property of sortByOrder(typeDef.properties || [])) {
    let typeName = toLuaType(property.type);
    if (property.optional === true) {
      typeName = `${typeName}|nil`;
    }

    lines.push(renderFieldAnnotation(property.name, typeName));

    if (property.alt_name && typeof property.alt_name === "string") {
      lines.push(renderFieldAnnotation(property.alt_name, typeName));
    }
  }

  if (typeDef.custom_properties && typeDef.custom_properties.key_type && typeDef.custom_properties.value_type) {
    lines.push(`---@field [${toLuaType(typeDef.custom_properties.key_type)}] ${toLuaType(typeDef.custom_properties.value_type)}`);
  }

  lines.push("");

  declaredTypeNames.add(typeDef.name);
}

function generatePrototypeStub(prototype, alreadyDeclaredTypeNames) {
  const lines = [];
  const declaredTypeNames = new Set(alreadyDeclaredTypeNames || []);

  lines.push("---@meta");
  lines.push("");
  lines.push(`-- Generated from Factorio prototype JSON docs (${prototype.application_version}, api v${prototype.api_version}).`);
  lines.push("");

  for (const typeDef of sortByOrder(prototype.types || [])) {
    if (!typeDef || typeof typeDef.name !== "string" || !isIdentifier(typeDef.name)) {
      continue;
    }

    if (declaredTypeNames.has(typeDef.name)) {
      continue;
    }

    if (typeDef.type && typeof typeDef.type === "object" && typeDef.type.complex_type === "struct") {
      renderPrototypeStructClass(lines, typeDef, declaredTypeNames);
      continue;
    }

    if (typeDef.properties && typeDef.properties.length > 0) {
      renderPrototypeStructClass(lines, typeDef, declaredTypeNames);
      continue;
    }

    const aliasType = typeDef.type === "builtin" ? "any" : toLuaType(typeDef.type);
    lines.push(`---@alias ${typeDef.name} ${aliasType}`);
    lines.push("");
    declaredTypeNames.add(typeDef.name);
  }

  for (const prototypeDef of sortByOrder(prototype.prototypes || [])) {
    renderPrototypeStructClass(lines, prototypeDef, declaredTypeNames);
  }

  lines.push("---@class data");
  lines.push("---@field raw table<string, table<string, table>>");
  lines.push("---@field extend fun(self: data, prototypes: table[])");
  lines.push("---@type data");
  lines.push("data = nil");
  lines.push("");

  lines.push("---@type table<string, string>");
  lines.push("mods = nil");
  lines.push("");

  return lines.join("\n");
}
