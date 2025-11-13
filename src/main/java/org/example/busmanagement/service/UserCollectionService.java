package org.example.busmanagement.service;

import org.example.busmanagement.model.entity.UserCollection;
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
}