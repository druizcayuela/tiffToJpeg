@RequestMapping(value = "/previewTiff", method = RequestMethod.POST)
	public final String previewTiff(
			final Map<String, Object> model,
			@ModelAttribute("imagesGetImageIDsForm") ImagesGetPreviewTiffImageContentServerID imagesGetPreviewTiffForm,
			final HttpServletRequest request, final HttpSession session,
			HttpServletResponse response) throws IOException, DocumentException {
		
		model.put("serverError", false);
		
		//Preparing ID for the WS. It expects to receive an ID for each image
		List<String> listContentServerID = imagesGetPreviewTiffForm.getContentServerIDList();

		// INITIALIZE BEANS to the call
		GetImageDto getImageDto = new GetImageDto();

		GetImageInputDocDto getImageInputReq = new GetImageInputDocDto();

		CommonInputsDto commonInputReq = new CommonInputsDto();
		
		LoginGroupsResultDto loginGroupResultDto = (LoginGroupsResultDto) session.getAttribute("loginGroupsResult");

		commonInputReq = UtilCompass.settingCommonInput4Images(loginGroupResultDto);
		
		byte[] bytesOfTiff = null;
		
		try {

			String contentServerID = listContentServerID.get(imagesGetPreviewTiffForm.getIndexPage());

			getImageInputReq.setObjectId(contentServerID);

			// ASIGNATE VALUES TO BEAN FOR SERVICE
			getImageDto.setCommonInputsReq(commonInputReq);
			getImageDto.setGetImageInput(getImageInputReq);

	    //Call to WS
			GetImageResultDocDto resultFrontImg = imagesService.getImage(getImageDto);
			
			//Byte arraay in base 64 from WS	
			bytesOfTiff = resultFrontImg.getImagecontent().getBase64Data();
				
	
	    /*
	    *
	    *
	    * HERE IS THE LOGIC WHERE CONVERT BYTE ARRAY FROM TIFF TO JPEG  
	    *
	    *
	    */
	
			List<String> imagesTiff = new ArrayList<String>();
			
			ByteArraySeekableStream stream = new ByteArraySeekableStream(bytesOfTiff);
			
			TIFFDecodeParam decodeParam = new TIFFDecodeParam();
			decodeParam.setDecodePaletteAsShorts(true);
			
			ImageDecoder dec = ImageCodec.createImageDecoder("tiff", stream, decodeParam);
			
			int pages = dec.getNumPages();
			
			
			for (int i = 0; i < pages; i++) {
				
				ByteArrayOutputStream bop = new ByteArrayOutputStream();
				JPEGEncodeParam jpgparam = new JPEGEncodeParam();
				jpgparam.setQuality(67);
				
				ImageEncoder en = ImageCodec.createImageEncoder("jpeg", bop, jpgparam);
				
				RenderedImage page = dec.decodeAsRenderedImage(i);

				en.encode(page);
				
				bop.flush();
				bop.close();
				
				byte[] bytesDecoded = bop.toByteArray();
			
				byte[] base64 = Base64.encodeBase64(bytesDecoded);

				String base64ToView = new String(base64);
				
				imagesTiff.add(base64ToView);
			}

			model.put("images", imagesTiff);
			model.put("previewTiffImageForm", imagesGetPreviewTiffForm);

			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("serverError", true);
			return "previewImage";
		} 
		
		return "previewImage";
	}
