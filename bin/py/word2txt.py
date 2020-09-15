# coding: utf-8
import fnmatch, os, sys, win32com.client
if __name__ == '__main__':
	wa = win32com.client.gencache.EnsureDispatch("Word.Application")
	try:
		for path, dirs, files in os.walk(sys.argv[1]): # コマンドラインより探索ディレクトリpathを取得
			for filename in files:
				if not fnmatch.fnmatch(filename, "*.doc"): continue # wordファイルの拡張子かをパターン・マッチング
				doc = os.path.abspath(os.path.join(path, filename)) # wordファイルへの絶対パスを作成
				print "processing %s in %s" % (doc, path)
				wa.Documents.Open(doc)
				txt = doc[:-3] + 'txt' # 変換保管するテキストファイル名
				wa.ActiveDocument.SaveAs(txt, FileFormat=win32com.client.constants.wdFormatText)
				wa.ActiveDocument.Close()
	finally:
		wa.Quit() # Wordの終了