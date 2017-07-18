# Java-ms-dockerbase

This image is based on Alpine 3.6 and provides OpenJDK 8 with 8.131.11-r0(JDK) version

## Avoiding JVM Delays Caused by Random Number Generation

The library used for random number generation in Sun's JVM relies on /dev/random by default for UNIX platforms.
This can potentially block the Server process because on some operating systems /dev/random waits for a certain amount
of "noise" to be generated on the host machine before returning a result.

That's why this image includes that setting by default allowing the use of urandom instead of random

## Folders

This image uses the '/data' folder as WORKDIR 

