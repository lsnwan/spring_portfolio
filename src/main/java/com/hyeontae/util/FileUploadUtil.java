package com.hyeontae.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Log4j
public class FileUploadUtil {

	// 유저프로필 업로드
	public String uploadUserProfile(String originalFile, String path, byte[] filedata) throws Exception {
		
		UUID uuid = UUID.randomUUID();
		String saveName = uuid.toString() + "_" + originalFile;
		File target = new File(path, saveName);
		File directory = new File(path);
		
		// 디렉토리 생성
		if(!directory.exists()) {
			try {
				directory.mkdir();
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		} else {
			// 폴더가 존재하면 안에 파일을 정리
			File[] files = directory.listFiles();
			
			for(int i=0; i<files.length; i++) {
				if(files[i].delete()) {
					log.info("파일정리완료");
				}
			}
		}
		
		FileCopyUtils.copy(filedata, target);
		
		return saveName;
	}
	
	// 썸네일 생성
	public String thumbnail(String rootPath, String uufile, MultipartFile file) {

		String thumbnailName = "s_" + uufile;
		
		try {
			
			FileOutputStream thumbnail = new FileOutputStream(new File(rootPath, thumbnailName));
			Thumbnailator.createThumbnail(file.getInputStream(), thumbnail, 250,250);
			thumbnail.close();
			
		} catch (Exception e) {
			log.info("썸네일 생성 실패");
			e.printStackTrace();
		}
		
		return thumbnailName;
	}
	
	// board 첨부파일 저장
	public void boardUpload(String fileName, String path, byte[] filedata) throws Exception {
		
		
		File target = new File(path, fileName);
		File directory = new File(path);
		
		// 디렉토리 생성
		if(!directory.exists()) {
			try {
				directory.mkdir();
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		
		FileCopyUtils.copy(filedata, target);
		
	}
	
}
