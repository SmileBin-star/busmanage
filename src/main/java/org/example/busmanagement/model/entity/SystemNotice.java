package org.example.busmanagement.model.entity;

import jakarta.persistence.Transient;
import lombok.Data;
import java.time.LocalDateTime;

@Data
public class SystemNotice {
    private Integer noticeId;         // 通知ID（PK）
    private String title;             // 标题
    private String content;           // 内容
    private Integer publisherId;      // 发布者ID（FK，关联用户表）
    private LocalDateTime publishTime; // 发布时间
    private Integer status;           // 状态：0-下架/1-发布中
    private Integer readCount;        // 阅读次数

    @Transient
    private String publisherName;     // 发布者名称（用于显示，非数据库字段）
}