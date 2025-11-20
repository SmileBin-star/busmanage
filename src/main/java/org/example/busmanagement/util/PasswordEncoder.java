package org.example.busmanagement.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * 密码加密工具类
 * 使用BCrypt算法进行密码加密和验证
 */
public class PasswordEncoder {

    /**
     * 加密密码
     * @param plainPassword 明文密码
     * @return BCrypt加密后的密码字符串
     */
    public static String encode(String plainPassword) {
        if (plainPassword == null || plainPassword.trim().isEmpty()) {
            throw new IllegalArgumentException("密码不能为空");
        }
        // BCrypt.gensalt() 默认强度为10，可以根据需要调整
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    /**
     * 验证密码
     * @param plainPassword 明文密码
     * @param hashedPassword BCrypt加密后的密码
     * @return true-密码匹配，false-密码不匹配
     */
    public static boolean matches(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 主方法 - 用于测试密码加密
     * 可以直接运行此类来加密密码
     */
    public static void main(String[] args) {
        // 示例用法
        if (args.length == 0) {
            System.out.println("=== 密码加密工具 ===");
            System.out.println("用法: java PasswordEncoder <明文密码>");
            System.out.println("示例: java PasswordEncoder 123456");
            System.out.println();
            
            // 默认示例
            String plainPassword = "123456";
            String encodedPassword = encode(plainPassword);
            System.out.println("明文密码: " + plainPassword);
            System.out.println("加密后: " + encodedPassword);
            System.out.println("验证结果: " + matches(plainPassword, encodedPassword));
        } else {
            // 从命令行参数获取密码
            String plainPassword = args[0];
            String encodedPassword = encode(plainPassword);
            System.out.println("明文密码: " + plainPassword);
            System.out.println("加密后的密码: " + encodedPassword);
            System.out.println();
            System.out.println("可以直接复制上面的加密密码用于数据库插入或更新操作");
        }
    }
}

