package com.rstoken;

import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;

import java.io.IOException;
import java.security.Key;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;

import java.security.spec.InvalidKeySpecException;

import java.util.Arrays;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

public class JwtRs extends ReactContextBaseJavaModule {

    private  ReactApplicationContext mContext;



    JwtRs(ReactApplicationContext context) throws NoSuchAlgorithmException, InvalidKeySpecException {
        super(context);
        mContext = context;
        
    }

    @ReactMethod
    public void generateJWT() throws InvalidKeySpecException, NoSuchAlgorithmException, IOException {
        Toast.makeText(mContext, "hello", Toast.LENGTH_SHORT).show();
        KeyPairGenerator kpg = KeyPairGenerator.getInstance("RSA");
        kpg.initialize(2048);
        KeyPair kp = kpg.generateKeyPair();


        Log.d("Private key",kp.getPrivate().toString());
        Log.d("Public key",kp.getPublic().toString());
        String publicKey = Base64.getEncoder().encodeToString(kp.getPublic().getEncoded());
        String privateKey = Base64.getEncoder().encodeToString(kp.getPrivate().getEncoded());
        JwtUtils jwtUtils = new JwtUtils();
        Map<String, Object> user = new HashMap<>();
        Map<String, String> data = new HashMap<>();

        data.put("store_id","369999");
        data.put("name","7now");
        user.put("'store_id'", "369999");
        user.put("Data",data);
        
        String jwtToken = jwtUtils.generateAccessToken("7now", user,privateKey);


        Log.d("jwtToken", jwtToken);
    }

    @NonNull
    @Override
    public String getName() {
        return "JwtRs";
    }
}
