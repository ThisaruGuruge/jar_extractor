
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
    var fileObject = getFileHandle(fileName);
    boolean fileExists = isFile(fileObject);
    if (!fileExists) {
        return createError("Provided file '" + fileName + "' does not exists");
    } else {
        var jarFile = getJarFileHandle(fileObject);
        if (jarFile is error) {
            return error(ERROR_REASON, message = "Failed to create Jar file object", cause = jarFile);
        } else {
            return jarFile;
        }
    }
}


