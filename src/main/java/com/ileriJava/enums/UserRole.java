package com.ileriJava.enums;

/**
 * @author furkancelik
 **/
public enum UserRole {

    USER("USER"),
    PERSONNEL("PERSONNEL"),
    ADMIN("ADMIN");
    private final String description;

    UserRole(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
