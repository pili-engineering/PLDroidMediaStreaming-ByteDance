package com.qiniu.pili.droid.streaming.demo.model;


public class ButtonItem {

    private String iconPath;
    private String title;
    private double defaultIntensity;
    private ComposerNode node;

    public ButtonItem(String iconPath, String title, double defaultIntensity, ComposerNode node) {
        this.iconPath = iconPath;
        this.title = title;
        this.defaultIntensity = defaultIntensity;
        this.node = node;
    }

    public String getIconPath() {
        return iconPath;
    }

    public void setIconPath(String icon) {
        this.iconPath = icon;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public ComposerNode getNode() {
        return node;
    }

    public void setNode(ComposerNode node) {
        this.node = node;
    }

    public double getDefaultIntensity() {
        return defaultIntensity;
    }

    public void setDefaultIntensity(double defaultIntensity) {
        this.defaultIntensity = defaultIntensity;
    }
}
