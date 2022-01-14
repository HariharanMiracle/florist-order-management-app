package com.boralesgamuwa.florists.ordermanagementapp.service.impl;

import com.boralesgamuwa.florists.ordermanagementapp.model.Package;
import com.boralesgamuwa.florists.ordermanagementapp.model.Packageitem;
import com.boralesgamuwa.florists.ordermanagementapp.model.Packitm;
import com.boralesgamuwa.florists.ordermanagementapp.repository.PackageRepository;
import com.boralesgamuwa.florists.ordermanagementapp.repository.PackageitemRepository;
import com.boralesgamuwa.florists.ordermanagementapp.repository.PackitmRepository;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackageService;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackitmService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

import static com.boralesgamuwa.florists.ordermanagementapp.util.Constant.ERROR_LOG;

@Service
@Slf4j
public class PackitmServiceImpl implements PackitmService {
    @Autowired
    PackitmRepository packitmRepository;

    @Autowired
    PackageRepository packageRepository;

    @Autowired
    PackageService packageService;

    @Autowired
    PackageitemRepository packageitemRepository;

    @Override
    @Transactional
    public boolean savePackItems(String[] newItemList, String packId) {

        List<Packitm> packitmList = new ArrayList<>();

        for (String itemId : newItemList) {
            Packitm packitm = new Packitm();
            packitm.setId(0);
            packitm.setPackageid(Integer.valueOf(packId));
            packitm.setPackageitemid(Integer.parseInt(itemId));
            packitmList.add(packitm);
        }

        try {
            double total;
            int packageId = packitmList.get(0).getPackageid();
            Package aPackage = packageRepository.findById(packageId).get();

            total = aPackage.getAmount();
            for (Packitm obj : packitmList) {
                Packageitem packageitem = packageitemRepository.findById(obj.getPackageitemid()).get();
                total += packageitem.getAmount();
            }

            aPackage.setAmount(total);

            packageService.editPackage(aPackage);
            packitmRepository.saveAll(packitmList);
            return true;
        } catch (Exception e) {
            log.error(ERROR_LOG, e);
            return false;
        }
    }

    @Override
    public boolean removePackItems(String[] newItemList, String packId) {
        List<Packitm> packitmList = new ArrayList<>();

        for (String itemId : newItemList) {
            packitmList.add(packitmRepository.findPackItemByPackageIdAndItemId(packId, itemId));
        }

        try {
            double total;
            int packageId = packitmList.get(0).getPackageid();
            Package aPackage = packageRepository.findById(packageId).get();

            total = aPackage.getAmount();
            for (Packitm obj : packitmList) {
                Packageitem packageitem = packageitemRepository.findById(obj.getPackageitemid()).get();
                total -= packageitem.getAmount();
            }

            aPackage.setAmount(total);

            packageService.editPackage(aPackage);

            /** Remove packNitem */
            for (Packitm obj : packitmList) {
                packitmRepository.delete(obj);
            }
            return true;
        } catch (Exception e) {
            log.error(ERROR_LOG, e);
            return false;
        }
    }
}
