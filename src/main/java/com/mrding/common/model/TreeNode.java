package com.mrding.common.model;

import java.util.*;

/**
 * 前台树形结构的节点数据所对应的java对象
 * 复合模式
 * @author mrding
 *
 */
public class TreeNode {
	
    private String text;
    private String id;
    private boolean leaf;
    private String cls;
    private String funcUrl;

    protected TreeNode() {}
    
    /**
     * 创建叶子节点
     * @param text
     * @param id
     * @param funcUrl
     * @return
     */
    public static TreeNode createLeaf(String text, String id, String funcUrl) {
	TreeNode node = new TreeNode();
        node.text = text;
	node.id = id;
	node.leaf = true;
	node.cls = "file";
	node.funcUrl = funcUrl;
	return node;
    }
    
    /**
     * 创建非叶子节点
     * @param text
     * @param id
     * @return
     */
    public static TreeNode createNotLeaf(String text, String id) {
	TreeNode node = new TreeNode();
        node.text = text;
	node.id = id;
	node.leaf = false;
	node.funcUrl = "";
	node.cls = "folder";
	return node;
    }

    public String getFuncUrl() {
        return funcUrl;
    }

    public void setFuncUrl(String funcUrl) {
        this.funcUrl = funcUrl;
    }

    public boolean isLeaf() {
        return leaf;
    }

    public void setLeaf(boolean leaf) {
        this.leaf = leaf;
    }

    public String getText() {
        return text;
    }
    public void setText(String text) {
        this.text = text;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getCls() {
        return cls;
    }
    public void setCls(String cls) {
        this.cls = cls;
    }
    
}
