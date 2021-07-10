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

    /**
     * Access: ADMIN
     * This function enables to add items to a package
     * This function also updates the package's total amount
     * */
    @Override
    public boolean savePackitm(List<Packitm> packitmList) {
        try{
            double total;
            int packageId = packitmList.get(0).getPackageid();
            Package aPackage = packageRepository.findById(packageId).get();

            total = aPackage.getAmount();
            for(Packitm obj : packitmList){
                Packageitem packageitem = packageitemRepository.findById(obj.getId()).get();
                total += packageitem.getAmount();
            }

            aPackage.setAmount(total);

            packageService.editPackage(aPackage);
            packitmRepository.saveAll(packitmList);
            return true;
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return false;
        }
    }
}
