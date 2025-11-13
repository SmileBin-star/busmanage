package org.example.busmanagement.service.impl;

import org.example.busmanagement.dao.UserCollectionMapper;
import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.UserCollection;
import org.example.busmanagement.service.UserCollectionService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class UserCollectionServiceImpl implements UserCollectionService {

    @Resource
    private UserCollectionMapper userCollectionMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addCollection(Integer userId, Integer collectionType, Integer targetId) {
        // 参数校验
        if (userId == null || collectionType == null || targetId == null) {
            throw new BusinessException("收藏参数不能为空");
        }

        // 检查是否已收藏
        UserCollection exist = userCollectionMapper.selectByUserAndTarget(userId, collectionType, targetId);
        if (exist != null) {
            throw new BusinessException("已收藏该内容，无需重复收藏");
        }

        // 新增收藏
        UserCollection collection = new UserCollection();
        collection.setUserId(userId);
        collection.setCollectionType(collectionType);
        collection.setTargetId(targetId);
        collection.setCollectionTime(LocalDateTime.now());
        return userCollectionMapper.insert(collection) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean cancelCollection(Integer userId, Integer collectionType, Integer targetId) {
        if (userId == null || collectionType == null || targetId == null) {
            throw new BusinessException("参数不能为空");
        }
        return userCollectionMapper.deleteByUserAndTarget(userId, collectionType, targetId) > 0;
    }

    @Override
    public List<UserCollection> getUserCollections(Integer userId, Integer collectionType) {
        if (userId == null) {
            throw new BusinessException("用户ID不能为空");
        }
        return userCollectionMapper.selectByUserId(userId, collectionType);
    }

    @Override
    public boolean isCollected(Integer userId, Integer collectionType, Integer targetId) {
        if (userId == null || collectionType == null || targetId == null) {
            return false;
        }
        UserCollection collection = userCollectionMapper.selectByUserAndTarget(userId, collectionType, targetId);
        return collection != null;
    }
}