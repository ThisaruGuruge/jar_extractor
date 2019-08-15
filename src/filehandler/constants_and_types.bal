const ERROR_REASON = "{thisaru/jar_extractor}Error";

type Detail record {
    string message;
    error cause?;
};

const JAR_UPPER = "JAR";
const JAR_LOWER = "jar";

type JarExtension JAR_UPPER|JAR_LOWER;

const CLASS_UPPER = "class";
const CLASS_LOWER = "CLASS";

type ClassExtension CLASS_UPPER|CLASS_LOWER;

# Error type for the `jar_extractor` module.
public type Error error<ERROR_REASON, Detail>;
