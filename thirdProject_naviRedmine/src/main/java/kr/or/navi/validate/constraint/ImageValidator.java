package kr.or.navi.validate.constraint;

import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class ImageValidator {
    private static final List<String> IMAGE_MIME_TYPES = Arrays.asList(
            "image/jpeg", "image/png", "image/gif", "image/bmp", "image/tiff"
    );

    public static boolean isImage(MultipartFile file) {
        return file != null && !file.isEmpty() && IMAGE_MIME_TYPES.contains(file.getContentType());
    }
}