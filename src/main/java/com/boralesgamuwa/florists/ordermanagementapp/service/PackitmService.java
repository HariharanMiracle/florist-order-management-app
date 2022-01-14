package com.boralesgamuwa.florists.ordermanagementapp.service;

import com.boralesgamuwa.florists.ordermanagementapp.model.Packitm;

import java.util.List;

public interface PackitmService {
    boolean savePackItems(String[] newItemList, String packId);
    boolean removePackItems(String[] newItemList, String packId);
}
