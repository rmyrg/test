import java.io.IOException;
import java.security.InvalidAlgorithmParameterException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertPath;
import java.security.cert.CertPathValidator;
import java.security.cert.CertPathValidatorResult;
import java.security.cert.CertPathValidatorException;
import java.security.cert.PKIXBuilderParameters;
import java.security.cert.PKIXCertPathValidatorResult;
import java.util.Set;
import java.util.HashSet;
// パス生成オブジェクトを生成
CertPathBuilder builder =
CertPathBuilder.getInstance("GPKI");
CertPathValidator validator =
CertPathValidator.getInstance("GPKI");
// 検査対象となる証明書を取得
X509Certificate targetCertificate =
getCertificate(certificateStore, argv[1]);
// トラストアンカーとする証明書を取得
X509Certificate trustCertificate = getCertificate(certificateStore, argv[2]);
// 構築パラメータ生成
CertPathParameters buildParameter = getCertPathParameters(
argv[0], validator, trustCertificate,
targetCertificate, certificateStore);
try {
 CertPathBuilderResult buildedPathResult =
 builder.build(buildParameter);
 certificatetionPath = buildedPathResult.getCertPath();
printCertPath(certificatetionPath);
 if(buildedPathResult instanceof PKIXCertPathBuilderResult)｛
PKIXCertPathBuilderResult result =
(PKIXCertPathBuilderResult)buildedPathResult;
PolicyNode policy = result.getPolicyTree();
if(policy != null) {
printPolicy(policy);
 }
 }
} catch(Exception e) {
e.printStackTrace();
}
try {
 CertPathValidatorResult result =
validator.validate(certificatetionPath, buildParameter);
 printCertPath(certificatetionPath);
 if(result instanceof PKIXCertPathValidatorResult) {
 PKIXCertPathValidatorResult r =
(PKIXCertPathValidatorResult)result;
 PolicyNode policy = r.getPolicyTree();
 if(policy != null) {
 printPolicy(policy);
 }
 }
} catch(Exception e) {
 e.printStackTrace();
}
