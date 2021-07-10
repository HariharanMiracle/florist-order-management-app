package com.boralesgamuwa.florists.ordermanagementapp.config;

import org.springframework.stereotype.Component;

import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.security.Key;

@Component
public class AES {

    private static final String ALGO = "AES";
    private byte[] keyValue;

    public AES() {
        String key = "lv39eptlvuhaqqsr";
        this.keyValue = key.getBytes();
    }

    public String encrypt(String Data) throws Exception{
        Key key = generateKey();
        Cipher c = Cipher.getInstance(ALGO);
        c.init(Cipher.ENCRYPT_MODE, key);
        byte[] encVal = c.doFinal(Data.getBytes());
        String encryptedValue = Base64.getEncoder().encodeToString(encVal);
        return encryptedValue;
    }

    public String decrypt(String encryptedData) throws Exception{
        Key key = generateKey();
        Cipher c = Cipher.getInstance(ALGO);
        c.init(Cipher.DECRYPT_MODE, key);
        byte[] decordedValue = Base64.getDecoder().decode(encryptedData);
        byte[] decValue = c.doFinal(decordedValue);
        String decryptedValue = new String(decValue);
        return decryptedValue;
    }

    private Key generateKey() throws Exception{
        Key key = new SecretKeySpec(keyValue, ALGO);
        return key;
    }
}