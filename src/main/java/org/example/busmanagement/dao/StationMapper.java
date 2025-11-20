package org.example.busmanagement.dao;

import org.example.busmanagement.model.entity.BusStation;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface StationMapper {

    // 分页查询所有站点
    List<BusStation> selectAll(@Param("pageNum") int pageNum, @Param("pageSize") int pageSize);

    // 查询总记录数
    int countTotal();

    // 根据ID查询站点
    BusStation selectById(Integer stationId);

    // 查询所有启用的站点（用于线路添加时选择站点）
    List<BusStation> selectAllActive();

    // 查询站点所属的线路（通过中间表关联）
    List<Integer> selectRouteIdsByStationId(Integer stationId);

    // 新增站点
    int insert(BusStation station);

    // 更新站点信息
    int update(BusStation station);

    // 更改站点状态（启用/关闭）
    int updateStatus(@Param("stationId") Integer stationId, @Param("status") Integer status);

    // 根据名称模糊查询站点
    List<BusStation> selectByNameLike(@Param("name") String name);
<<<<<<< HEAD

    // 删除站点
    int deleteById(Integer stationId);
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
}