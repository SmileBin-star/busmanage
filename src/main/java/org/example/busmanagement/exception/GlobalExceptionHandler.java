package org.example.busmanagement.exception;

<<<<<<< HEAD
import jakarta.servlet.http.HttpServletRequest;
import org.example.busmanagement.model.vo.Result;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
=======
import org.example.busmanagement.model.vo.Result;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
<<<<<<< HEAD
    public Object handleException(Exception e, HttpServletRequest request) {
        e.printStackTrace();
        // 判断是否是 AJAX 请求或 API 请求
        String accept = request.getHeader("Accept");
        String contentType = request.getContentType();
        boolean isAjaxRequest = (accept != null && accept.contains("application/json")) 
                || (contentType != null && contentType.contains("application/json"))
                || "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        
        if (isAjaxRequest) {
            // API 请求返回 JSON
            return Result.error("系统异常：" + e.getMessage());
        } else {
            // 视图请求返回错误页面
            ModelAndView mv = new ModelAndView("common/error");
            mv.addObject("error", "系统异常：" + e.getMessage());
            return mv;
        }
    }

    @ExceptionHandler(BusinessException.class)
    public Object handleBusinessException(BusinessException e, HttpServletRequest request) {
        // 判断是否是 AJAX 请求
        String accept = request.getHeader("Accept");
        String contentType = request.getContentType();
        boolean isAjaxRequest = (accept != null && accept.contains("application/json")) 
                || (contentType != null && contentType.contains("application/json"))
                || "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        
        if (isAjaxRequest) {
            return Result.error(e.getMessage());
        } else {
            ModelAndView mv = new ModelAndView("common/error");
            mv.addObject("error", e.getMessage());
            return mv;
        }
=======
    @ResponseBody
    public Result handleException(Exception e) {
        e.printStackTrace();
        return Result.error("系统异常：" + e.getMessage());
    }

    @ExceptionHandler(BusinessException.class)
    @ResponseBody
    public Result handleBusinessException(BusinessException e) {
        return Result.error(e.getMessage());
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
    }
}