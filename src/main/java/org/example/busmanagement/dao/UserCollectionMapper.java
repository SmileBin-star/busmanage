package org.example.busmanagement.dao;

import org.example.busmanagement.model.entity.UserCollection;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface UserCollectionMapper {

    // 新增收藏
    int insert(UserCollection collection);

    // 取消收藏（按ID）
    int deleteById(Integer collectionId);

    // 取消收藏（按用户ID+类型+目标ID）
    int deleteByUserAndTarget(@Param("userId") Integer userId,
                              @Param("collectionType") Integer collectionType,
                              @Param("targetId") Integer targetId);

    // 按用户ID查询收藏列表
    List<UserCollection> selectByUserId(@Param("userId") Integer userId,
                                        @Param("collectionType") Integer collectionType);

    // 检查是否已收藏
    UserCollection selectByUserAndTarget(@Param("userId") Integer userId,
                                         @Param("collectionType") Integer collectionType,
                                         @Param("targetId") Integer targetId);

    // 分页查询用户收藏列表
    List<UserCollection> selectPageByUserId(@Param("userId") Integer userId,
                                           @Param("collectionType") Integer collectionType,
                                           @Param("pageNum") int pageNum,
                                           @Param("pageSize") int pageSize);

    // 统计用户收藏总数
    int countByUserId(@Param("userId") Integer userId,
                     @Param("collectionType") Integer collectionType);
}