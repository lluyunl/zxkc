package com.mrding.common.web;

import java.lang.reflect.*;
import java.util.*;

import com.opensymphony.xwork2.ModelDriven;

public class ActionSupport<V, M> implements ModelDriven<V> {
    
    protected M manager = getManagerInstance();
    protected V model = getVoInstance();
    protected List<Object> jsonList = new ArrayList<Object>();
    protected Map<String, Object> jsonMap = new HashMap<String, Object>();
    
    public Map<String, Object> getJsonMap() {
        return jsonMap;
    }

    public List<Object> getJsonList() {
	return jsonList;
    }

    @Override
    public V getModel() {
	return null;
    }

    private V getVoInstance() {
	try {
            return ((Class<V>) getTypeArgs()[0]).newInstance();
	} catch(Exception e) {
	    return null;
	}
    }

    private M getManagerInstance() {
	try {
            return ((Class<M>) getTypeArgs()[1]).newInstance();
	} catch(Exception e) {
	    return null;
	}
    }

    private Type[] getTypeArgs() {
	Type sType = getClass().getGenericSuperclass();
        Type[] generics = ((ParameterizedType) sType).getActualTypeArguments();
	return generics;
    }
    
    

}
