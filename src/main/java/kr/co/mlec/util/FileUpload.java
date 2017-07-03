package kr.co.mlec.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.mlec.dao.BoardDao;
import kr.co.mlec.vo.FileVO;

public class FileUpload {
	
	@Inject
	private BoardDao dao;
	
	public FileVO fileUpload(MultipartFile file, int no, int type) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("/yyyy/MM/dd");
		String datePath = sdf.format(new Date());
		String savePath = "c://study" + datePath;
		
		File f = new File(savePath);
		
		if (!f.exists()) f.mkdirs();
		
			String oriFileName = file.getOriginalFilename();
			
			if (oriFileName != null && !oriFileName.equals("")) {
				String ext = "";
				int index = oriFileName.lastIndexOf(".");
				if (index != -1) {
					ext = oriFileName.substring(index);
				}
				String saveFileName = new SimpleDateFormat("yyyyMMdd").format(new Date()) + UUID.randomUUID().toString() + ext;
				FileVO fv = new FileVO();
				fv.setBoard_no(no);
				fv.setBoard_type(type);
				fv.setFilePath(datePath);
				fv.setOriName(oriFileName);
				fv.setSysName(saveFileName);
				if (type == 1) {
					if (dao.insertFile(fv) == 1) {
						file.transferTo(new File(savePath + "/" + saveFileName));
						return fv;
					}					
				} else if (type == 2) {
					file.transferTo(new File(savePath + "/" + saveFileName));
					return fv;
				}
			}
		return null;
	}
}
