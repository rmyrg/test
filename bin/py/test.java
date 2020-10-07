	public static void main(String[] args) throws CertificateException, FileNotFoundException {
	    // open an input stream to the file
	    FileInputStream fis = new FileInputStream("/Users/rmg/Downloads/GTS Root R1.cer");
	    // instantiate a CertificateFactory for X.509
	    CertificateFactory cf = CertificateFactory.getInstance("X.509");
	    // X.509証明書の抽象クラス
	    X509Certificate cert = (X509Certificate) cf.generateCertificate(fis);
	    System.out.println(cert.getCriticalExtensionOIDs());
	    System.out.println(cert.getSigAlgName());
	    System.out.println(cert.getSigAlgOID());
	    Date date = new Date(120,3,13);
	    System.out.println(date);
	    // 証明書が現在有効であるかどうかを判定 無効の場合、CertificateExpiredException
	    cert.checkValidity(date);
	    // クリティカルなBasicConstraints拡張機能(OID = 2.5.29.19)から証明書の制約のパスの長さを取得
	    System.out.println(cert.getBasicConstraints());

	    X500Principal xp = cert.getIssuerX500Principal();
	    System.out.println(xp.getName());
	    // 証明書の有効期間からnotAfterの日付を取得
	    System.out.println(cert.getNotAfter());
	    // 証明書の有効期間からnotBeforeの日付を取得
	    System.out.println(cert.getNotBefore());
	    // 証明書からserialNumber値を取得
	    System.out.println(cert.getSerialNumber());

	    // CertificateException
	    CertPath cp = cf.generateCertPath(fis);
	    System.out.println(cp.getType());
//	    // print each certificate in the path
//	    List<? extends Certificate> certs = cp.getCertificates();
//	    for (Certificate cert : certs) {
//	        System.out.println(cert);
//	    }
	}
