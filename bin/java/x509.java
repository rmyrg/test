package com.example.demo;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.security.cert.CertPath;
import java.security.cert.Certificate;
import java.security.cert.CertificateException;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.security.auth.x500.X500Principal;

public class test {
//	@Autowired
//	TrustAnchor ta;
//	@Autowired
//	CertificateFactory cf;
//
//	public void calc() throws CertificateException, FileNotFoundException, CRLException {
//		X509Certificate xc = ta.getTrustedCert();
//
//		// X509 PKI管理ファクトリの生成
//		CertificateFactory factory = CertificateFactory.getInstance("X.509");
//
//		// CRLファイルの読み込み
//		InputStream ins = new FileInputStream(new File("./crl.crl"));
//
//		// CRLのインスタンス
//		X509CRL crl = (X509CRL) factory.generateCRL(ins);
//
//		// チェック対象の証明書
//		InputStream ins2 = new FileInputStream(new File("./client.crt"));
//		X509Certificate cert = (X509Certificate) factory.generateCertificate(ins2);
//
//		// 証明書が失効されているかを判定する
//		boolean revoke = crl.isRevoked(cert);
//
//		CertPath cp = cf.generateCertPath(new FileInputStream(new File("./client.crt")));
//	}

	private static String BASIC_CONSTRAINTS = "2.5.29.14";

	public static void main(String[] args) throws CertificateException, FileNotFoundException {
	    // open an input stream to the file
	    FileInputStream fis = new FileInputStream("BCAself.der");
	    // instantiate a CertificateFactory for X.509
	    CertificateFactory cf = CertificateFactory.getInstance("X.509");
	    // X.509証明書の抽象クラス
	    X509Certificate cert = (X509Certificate) cf.generateCertificate(fis);
	    // (X509Extension) Set<String> CRITICALとしてマーキングされている拡張のOID文字列のSetを取得します。
	    for(String str : cert.getCriticalExtensionOIDs()) {
	    	System.out.println(str);
	    	System.out.println(cert.getExtensionValue(str));
	    }

	    long cnt = cert.getNonCriticalExtensionOIDs().parallelStream().filter(s -> s.equals(BASIC_CONSTRAINTS)).count();
	    System.out.println(cnt);

	    boolean bl = false;
	    for(String str : cert.getNonCriticalExtensionOIDs()) {
	    	if(BASIC_CONSTRAINTS.equals(str)) {
	    		bl = true;
	    	}
	    }
	    System.out.println(bl);
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

        try {
            CertPath cp = cf.generateCertPath(fis, "X.509");
            List<? extends Certificate> certs = cp.getCertificates();
            Iterator<? extends Certificate> i = certs.iterator();
            System.out.println("証明書数 = " + certs.size());
            while (i.hasNext()) {
                X509Certificate cert2 = (X509Certificate)i.next();
                System.out.println(cert2);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
//	    // print each certificate in the path
//	    List<? extends Certificate> certs = cp.getCertificates();
//	    for (Certificate cert : certs) {
//	        System.out.println(cert);
//	    }
	}
	
	
	
        X509Extension x509e = null;
        List<NwsX509Certificate> nwsX509CertificateList= new ArrayList<NwsX509Certificate>();

        try (DirectoryStream<Path> dirStream = Files.newDirectoryStream(Paths.get(storePath))) {
            Iterator<Path> it = dirStream.iterator();
            while(it.hasNext()) {
                Path containFile = it.next();
//                System.out.println(containFile);

                String fileName = containFile.getFileName().toString();
//                System.out.println(containFile.getParent());
                CertificateFactory factory = null;
                try {
                    factory = CertificateFactory.getInstance("X.509");
                } catch (CertificateException e) {
                    throw new IllegalArgumentException(e);
                }
                try (BufferedInputStream targetStream = new BufferedInputStream(Files.newInputStream(containFile))) {
                    x509e = (X509Certificate) factory.generateCertificate(targetStream);
                    NwsX509Certificate nwsX509Certificate = new NwsX509Certificate(containFile,fileName, x509e);
                    nwsX509CertificateList.add(nwsX509Certificate);
//                    System.out.println(nwsX509Certificate.getType());
//                    System.out.println("509Extensionを継承したオブジェクト");
//                    System.out.println(x509e.getNonCriticalExtensionOIDs());
                } catch (IOException | CertificateException e) {
                    e.printStackTrace();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        String spa = FileSystems.getDefault().getSeparator();

        for(NwsX509Certificate nwsX509c : nwsX509CertificateList) {
            X509Certificate x509ex =(X509Certificate) nwsX509c.getX509Extension();
            if(nwsX509c.getType().equals("self") && NwsX509Certificate.getMaxNotAfter().equals(x509ex.getNotAfter())){
                System.out.println(nwsX509c.getPath());
                Path targetPath = Paths.get(nwsX509c.getPath().getParent() + spa + "NO_" + nwsX509c.getPath().getFileName());
                try {
                    Files.move(nwsX509c.getPath(), targetPath, StandardCopyOption.REPLACE_EXISTING);
                } catch (IOException e) {
                    e.printStackTrace();
                }

            }
        }
}
