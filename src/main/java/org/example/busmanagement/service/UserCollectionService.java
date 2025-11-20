package org.example.busmanagement.service;

import org.example.busmanagement.model.entity.UserCollection;
<<<<<<< HEAD
import org.example.busmanagement.model.vo.PageResult;
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
import java.util.List;

public interface UserCollectionService {

    // 添加收藏
    boolean addCollection(Integer userId, Integer collectionType, Integer targetId);

    // 取消收藏
    boolean cancelCollection(Integer userId, Integer collectionType, Integer targetId);

    // 查询用户收藏列表
    List<UserCollection> getUserCollections(Integer userId, Integer collectionType);

    // 检查是否已收藏
    boolean isCollected(Integer userId, Integer collectionType, Integer targetId);
<<<<<<< HEAD

    // 分页查询用户收藏列表
    PageResult<UserCollection> getUserCollectionsPage(Integer userId, Integer collectionType, int pageNum, int pageSize);

    // 按ID删除收藏
    boolean deleteCollectionById(Integer collectionId);
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
}