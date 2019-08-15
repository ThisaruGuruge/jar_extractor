import ballerina/filepath;
import ballerinax/java;

function isFile(handle fileReceiver) returns boolean = @java:Method {
    name: "isFile",
    class: "java.io.File"
} external;

function getFileHandle(string path) returns handle = @java:Constructor {
    class: "java.io.File",
    paramTypes: ["java.lang.String"]
} external;

function getJarFileHandle(handle fileObject) returns handle|error = @java:Constructor {
    class: "java.util.jar.JarFile",
    paramTypes: ["java.io.File"]
} external;

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