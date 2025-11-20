package org.example.busmanagement.model.entity;

<<<<<<< HEAD
import jakarta.persistence.Transient;
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
import lombok.Data;
import java.time.LocalDateTime;

@Data
public class UserCollection {
    private Integer collectionId;      // 收藏ID（PK）
    private Integer userId;            // 用户ID（FK）
    private Integer collectionType;    // 收藏类型：1-线路/2-站点等
    private Integer targetId;          // 目标ID（关联的线路ID或站点ID等）
    private LocalDateTime collectionTime;  // 收藏时间
<<<<<<< HEAD

    @Transient
    private String targetName;         // 目标名称（线路名称或站点名称，用于显示）
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
}