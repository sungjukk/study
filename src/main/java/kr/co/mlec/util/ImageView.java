package kr.co.mlec.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.Closeable;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLDecoder;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/image")
public class ImageView {
	
	private String baseFilePath = "C://study";
	private static final int size = 10240;
	
	@RequestMapping(method = RequestMethod.GET)
	public void imageViewer(String file, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String[] imgFile = file.split("/");
		if (imgFile.length <= 4) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		
		String path = baseFilePath + file.replace(imgFile[4], "");
		String fileName = imgFile[4];
		
		if (imgFile[3] == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		
		File image = new File(path + fileName);
		
		if (!image.exists()) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		
		String contentType = request.getSession().getServletContext().getMimeType(image.getName().toLowerCase());
		
		if (contentType == null || !contentType.startsWith("image")) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		
		response.reset();
		response.setBufferSize(size);
		response.setHeader("Content-Type", contentType);
		response.setHeader("Content-Length", String.valueOf(image.length()));
		response.setHeader("Content-Disposition", "inline; filename=\"" + image.getName() + "\"");
		
		BufferedInputStream is = null;
		BufferedOutputStream os = null;
		
		try {
			is = new BufferedInputStream(new FileInputStream(image), size);
			os = new BufferedOutputStream(response.getOutputStream(), size);
			
			byte[] buffer = new byte[size];
			int length;
			while ((length = is.read(buffer)) > 0) {
				os.write(buffer, 0, length);
			}
			
			os.flush();
		} finally {
			close(os);
			close(is);
		}
	}
	
	private static void close(Closeable resource) {
		if (resource != null) {
			try {
				resource.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
