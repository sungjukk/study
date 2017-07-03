package kr.co.mlec.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.mlec.vo.FileVO;

@Controller
public class Download {
	
	private String baseFilePath = "C://study";
	
	@Autowired
	private DownloadService downloadService;
	
	@RequestMapping(value="/download/{no}", method = RequestMethod.GET)
	public void download(@PathVariable("no") int no, HttpServletResponse response) throws Exception {
		FileVO fv = downloadService.getFile(no);
		String downName = new String(fv.getOriName().getBytes("UTF-8"), "8859_1");
		File f = new File(baseFilePath + fv.getFilePath() + "/" + fv.getSysName());
		response.setHeader("Content-Type", "application/octet-stream");
		response.setHeader("Content-Disposition", "attachment;filename=" + downName);
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Length", String.valueOf(f.length()));
		
		FileInputStream fls = new FileInputStream(f);
		BufferedInputStream bis = new BufferedInputStream(fls);
		
		OutputStream out = response.getOutputStream();
		BufferedOutputStream bos = new BufferedOutputStream(out);
		
		while (true) {
			int ch = bis.read();
			if (ch == -1) break;
			
			bos.write(ch);
		}
		
		bis.close();
		fls.close();
		bos.close();
		out.close();
	}
	
	@RequestMapping(value="/fDelete/{no}", method = RequestMethod.GET)
	public boolean fileDelete() throws Exception {
		return false;
	}
}
