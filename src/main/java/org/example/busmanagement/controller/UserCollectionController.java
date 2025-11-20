package org.example.busmanagement.controller;

import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.UserCollection;
import org.example.busmanagement.model.vo.Result;
import org.example.busmanagement.model.vo.PageResult;
import org.example.busmanagement.service.UserCollectionService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
@RequestMapping("/collection")
public class UserCollectionController {

    @Resource
    private UserCollectionService userCollectionService;

    @PostMapping("/add")
    @ResponseBody
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
    @ResponseBody
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

    // 我的收藏页面（管理页面）
    @GetMapping("/manage")
    public String manage() {
        return "collection/manage";
    }

    // 我的收藏列表页面
    @GetMapping("/list")
    public String listPage() {
        return "collection/list";
    }

    /**
     * 查询用户收藏列表（分页）- API接口
     */
    @GetMapping("/api/list")
    @ResponseBody
    public Result getUserCollectionsPage(
            @RequestParam Integer userId,
            @RequestParam(required = false) Integer type,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        try {
            PageResult<UserCollection> pageResult = userCollectionService.getUserCollectionsPage(userId, type, pageNum, pageSize);
            return Result.success(pageResult);
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    /**
     * 查询用户收藏列表（不分页，保留兼容）
     */
    @GetMapping("/listAll")
    @ResponseBody
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
     * 按ID删除收藏
     */
    @PostMapping("/delete/{collectionId}")
    @ResponseBody
    public Result deleteCollection(@PathVariable Integer collectionId) {
        try {
            boolean success = userCollectionService.deleteCollectionById(collectionId);
            return success ? Result.success("删除成功") : Result.error("删除失败");
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
    @ResponseBody
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