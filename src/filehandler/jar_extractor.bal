import ballerina/io;
import ballerina/system;

# Check and open a provided jar file if exists.
#
# + fileName - Name of the jar file to get the handle
# + return - `handle` object off the jar file, or a `Error` if the operation fails
public function getJarFileHandler(string fileName) returns handle|Error {
    var isJarFile = isJarFile(fileName);
    if (isJarFile is Error) {
        return isJarFile;
    } else if (!isJarFile) {
        return createError("Invalid jar file provided");
    }
    boolean fileExists = system:exists(fileName);
    if (!fileExists) {
        return createError("Provided file '" + fileName + "' does not exists");
    } else {
        var fileObject = getFileHandle(fileName);
        var jarFile = getJarFileHandle(fileObject);
        if (jarFile is error) {
            return error(ERROR_REASON, message = "Failed to create Jar file object", cause = jarFile);
        } else {
            return jarFile;
        }
    }
}

public function createFile(string fileName, byte[] content) returns @tainted Error? {
    var file = io:openWritableFile(fileName);
    if (file is error) {
        return createError("File creation failed", file);
    }
    var writeResult = file.write(content);
    if (writeResult is error) {
        return createError("Failed to write to the file", writeResult);
    }
    var closeResult = file.close();
    if (closeResult is error) {
        return createResult("Failed to close the file", closeResult);
    }
}
