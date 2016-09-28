rem Script: Generate Keystore
set DOMAIN_HOME=D:\mydocs\study stuff\key and trust generation
cd %DOMAIN_HOME%\keystores

set JDK_HOME="/bin"
set ALIAS="neeraj"
set DNAME="CN=localhost, OU=CRISIL Technology, O=CRISIL, L=Mumbai, ST=StateOfMind, C=IN"
set KEYPASS="password"
set IDENTITY_JKS="identity.jks"
set STOREPASS="password"
set CERT_CER="cert.cer"
set TRUST_JKS="trust.jks"

rem #create-keystore
echo "Creating keystore"
keytool -genkey -alias %ALIAS% -keyalg RSA -keysize 2048 -sigalg SHA256withRSA -dname %DNAME% -keypass %KEYPASS% -keystore %IDENTITY_JKS% -storepass %STOREPASS%

rem #Self Signing the Certificate
echo "Self Signing the Certificate"
keytool -selfcert -alias %ALIAS% -dname %DNAME% -keypass %KEYPASS% -keystore %IDENTITY_JKS% -storepass %STOREPASS%

rem #Exporting the Server certificate
echo "Exporting the Server certificate"
keytool -export -alias %ALIAS% -file %CERT_CER% -keystore %IDENTITY_JKS% -storepass %STOREPASS%

rem #Creating Trust Store
echo "Creating Trust Store"
keytool -import -alias %ALIAS% -file %CERT_CER% -keystore %TRUST_JKS% -sigalg SHA256withRSA -storepass %STOREPASS% -noprompt

echo ""
echo "Done"
echo ""
pause