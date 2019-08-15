
public function main() {
    string[] fileNames = ["c:\\test\\kafka-clients-2.0.0.jar", "invalid.extension", "invalid_file.jar"];
    foreach string fileName in fileNames {
        io:print("File Name: '");
        io:print(fileName);
        io:print("'\tValue: ");
        var jarFile = getJarFileHandler(fileName);
        io:println(jarFile);
    }

    var result = createFile("c:\\test\\sample\\another\\level\\sample.txt");
    if (result is error) {
        io:println(result);
    }
}
