	public static void main(String[] args) throws CertificateException, FileNotFoundException {
	    // open an input stream to the file
	    FileInputStream fis = new FileInputStream("/Users/rmg/Downloads/bcau8ver4.cer");
	    // instantiate a CertificateFactory for X.509
	    CertificateFactory cf = CertificateFactory.getInstance("X.509");
	    X509Certificate cert = (X509Certificate) cf.generateCertificate(fis);
	    System.out.println(cert.getCriticalExtensionOIDs());
	    System.out.println(cert.getSigAlgName());
	    System.out.println(cert.getSigAlgOID());
//	    // extract the certification path from
//	    // the PKCS7 SignedData structure
//	    CertPath cp = cf.generateCertPath(fis);
//	    // print each certificate in the path
//	    List<? extends Certificate> certs = cp.getCertificates();
//	    for (Certificate cert : certs) {
//	        System.out.println(cert);
//	    }
	}
