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

# Returns a handle object to a Java array of files inside the jar file.
#
# + jarFile - handle object for java file
# + returns - handle to Java array
public function getFileArray(handle jarFile) returns handle {
    var entries = getEntriesOfJar(jarFile);
    var entriesList = toList(entries);
    return getArray(entriesList);
}

# Creates a file for the provided name, and writes the content.
#
# + fileName - Name of the file
# + content - Content to write to the file
# + returns - `Error` if the process failed, nil otherwise
public function createFile(string fileName, byte[] content) returns @tainted Error? {
    var file = io:openWritableFile(fileName);
    if (file is error) {
        return createError("File creation failed", file);
    } else {
        var writeResult = file.write(content, 0);
        if (writeResult is error) {
            return createError("Failed to write to the file", writeResult);
        }
        var closeResult = file.close();
        if (closeResult is error) {
            return createError("Failed to close the file", closeResult);
        }
    }
}
