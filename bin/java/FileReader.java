package javase11.test;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;

public class Main {

	public static void main(String[] args) {
		File file = new File(".\fileSample.txt");
		Main main = new Main();
		main.FileReader1(file);
		main.BinaryReader1(file);
	}

	/**
	 * FileReaderで読み込む
	 */
	public void FileReader1(File file)  {
		try (BufferedReader br = new BufferedReader(new FileReader(file))) {
			String text;
			while ((text = br.readLine()) != null) {
				System.out.println(text);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void BinaryReader1(File file) {
		try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file))) {
			byte[] bytes = new byte[1024];
			while ((bis.read(bytes, 0, bytes.length)) != -1) {
				System.out.println(bytes);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}



}
