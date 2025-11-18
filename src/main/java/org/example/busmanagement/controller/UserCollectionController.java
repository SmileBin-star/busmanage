package org.example.busmanagement.controller;

import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.UserCollection;
import org.example.busmanagement.model.vo.Result;
import org.example.busmanagement.service.UserCollectionService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/collection")
public class UserCollectionController {

    @Resource
    private UserCollectionService userCollectionService;

    @PostMapping("/add")
    public Result addCollection(
            @RequestParam Integer userId,
            @RequestParam Integer type,
            @RequestParam Integer targetId) {
        try {
            boolean success = userCollectionService.addCollection(userId, type, targetId);
            return success ? Result.success("收藏成功") : Result.error("收藏失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    @PostMapping("/cancel")
    public Result cancelCollection(
            @RequestParam Integer userId,
            @RequestParam Integer type,
            @RequestParam Integer targetId) {
        try {
            boolean success = userCollectionService.cancelCollection(userId, type, targetId);
            return success ? Result.success("取消收藏成功") : Result.error("取消收藏失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    /**
     * 查询用户收藏列表
     */
    @GetMapping("/list")
    public Result getUserCollections(
            @RequestParam Integer userId,
            @RequestParam(required = false) Integer type) {
        try {
            List<UserCollection> collections = userCollectionService.getUserCollections(userId, type);
            return Result.success(collections);
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    /**
     * 检查是否已收藏
     */
    @GetMapping("/check")
    public Result checkCollection(
            @RequestParam Integer userId,
            @RequestParam Integer type,
            @RequestParam Integer targetId) {
        try {
            boolean isCollected = userCollectionService.isCollected(userId, type, targetId);
            return Result.success(isCollected);
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }
}