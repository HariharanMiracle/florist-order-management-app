package com.boralesgamuwa.florists.ordermanagementapp.service;

import com.boralesgamuwa.florists.ordermanagementapp.model.Packitm;

import java.util.List;

public interface PackitmService {
    boolean savePackitm(List<Packitm> packitmList);

    boolean savePackItems(String[] newItemList, String packId);
}
