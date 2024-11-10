import * as admin from "firebase-admin"
import * as functions from "firebase-functions/v1"
import * as logger from "firebase-functions/logger"
import * as firestore from "@google-cloud/firestore"

admin.initializeApp()

export const makeAdminIfWhiteListed = functions.auth.user().onCreate(async (user,_) =>{
    const email = user.email
    if(email === undefined){
        logger.log(`User ${user.uid} doesn't have an email address`)
        return
    }

    if(!email.endsWith("@test.com")){
        logger.log(`${email} doesn't belong to a whitelisted domain`)
        return
    }

    if(user.customClaims?.admin === true){
        logger.log(`${email} is already an admin`)
        return
    }

    admin.auth().setCustomUserClaims(user.uid, {
        admin: true,
    })

    await admin.firestore().doc(`metadata/${user.uid}`).set({
        refreshTime: firestore.FieldValue.serverTimestamp(),
    })

    logger.log(`Custom claim set! ${email} is now an admin`)
})