import ballerina/filepath;
import ballerinax/java;

// Constructors
function getFileHandle(string path) returns handle = @java:Constructor {
    class: "java.io.File",
    paramTypes: ["java.lang.String"]
} external;

function getJarFileHandle(handle fileObject) returns handle|error = @java:Constructor {
    class: "java.util.jar.JarFile",
    paramTypes: ["java.io.File"]
} external;

// Java methods
function getEntriesOfJar(handle jarFile) returns handle = @java:Method {
    name: "entries",
    class: "java.util.jar.JarFile"
} external;

function toList(handle entries) returns handle = @java:Method {
    name: "list",
    class: "java.util.Collections"
} external;

function getArray(handle collection) returns handle = @java:Method {
    name: "toArray",
    class: "java.util.ArrayList"
} external;

function getInputStream(handle jarFile, handle file) returns handle|error = @java:Method {
    name: "getInputStream",
    class: "java.util.jar.JarFile"
} external;

function getFileContent(handle filePath, byte[] content) returns int|error = @java:Method {
    name: "read",
    class: "java.io.InputStream"
} external;

function getFileName(handle file) returns string = @java:Method {
    name: "getName",
    class: "java.util.jar.JarEntry"
} external;

// Other utility functions
function writeClassFiles(handle jarFile, handle fileArray) returns handle {
    int length = java:getArrayLength(fileArray);
    int  count = 0;
    while (count < length) {
        handle file = java:getArrayElement(fileArray, count);
        string fileName = getFileName(file);
        var isClassFile = isClassFile(fileName);
        if (isClassFile is error) {
            io:println(isClassFile);
        } else if (isClassFile) {
            var inputStream = getInputStream(jarFile, file);
            if (inputStream is error) {
                io:println(inputStream);
            } else {
                byte[] content = [];
                var byteLength = getFileContent(inputStream, content);
                var result = createFile(fileName, content);
            }
        }
        count += 1;
    }
    return fileArray;
}

function isJarFile(string fileName) returns boolean|Error {
    var extension = filepath:extension(fileName);
    if (extension is filepath:Error) {
        return createError("Unknown filepath error occurred", extension);
    }
    return (extension is JarExtension);
}

function isClassFile(string fileName) returns boolean|Error {
    var extension = filepath:extension(fileName);
    if (extension is filepath:Error) {
            return createError("Unknown filepath error occurred", extension);
    }
    return (extension is ClassExtension);
}

function createError(string message, error? cause = ()) returns Error {
    if (cause is error) {
        return error(ERROR_REASON, message = message, cause = cause);
    } else {
        return error(ERROR_REASON, message = message);
    }
}