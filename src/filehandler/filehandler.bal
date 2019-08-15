import ballerinax/java;

public function isFile(handle fileReceiver) returns boolean = @java:Method {
    name: "isFile",
    class: "java.io.File"
} external;

public function createFile(string path) returns handle = @java:Constructor {
    class: "java.io.File",
    paramTypes: ["java.lang.String"]
} external;
