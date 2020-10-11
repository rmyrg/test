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
static public final String DEFAULT_IMPLEMENTATION_NAME = "PKIX";
public CertPathValidatorResult validate(
String implementationName,
Set trustAnchor,
CertPath path,
boolean anyPolicyInhibit,
boolean policyMappingInhibit,
boolean explicitPolicy,
Set initialPolicy)
throws CertPathValidatorException {
PKIXBuilderParameters params = null;
CertPathValidator validator = null;
try { // パラメータの用意をします
params = new PKIXBuilderParameters(trustAnchor, null);
params.setAnyPolicyInhibited(anyPolicyInhibit);
params.setExplicitPolicyRequired(explicitPolicy);
params.setPolicyMappingInhibited(policyMappingInhibit);
params.setInitialPolicies(initialPolicy);
// 適当なリポジトリを設定してください
} catch(InvalidAlgorithmParameterException iape) {
throw new CertPathValidatorException(iape);
 }
