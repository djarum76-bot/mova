package models

import (
	"strconv"
	"time"

	"github.com/midtrans/midtrans-go"
	"github.com/midtrans/midtrans-go/coreapi"
)

const SERVER_KEY string = "SB-Mid-server-AkT7pmgtwNKMRHSRDnDI-EHp"
const CLIENT_KEY string = "SB-Mid-client-AScTcfQ2MpWK7Eu1"

func generateOrderIdSuffix() string {
	return strconv.FormatInt(time.Now().Unix(), 10)
}

func ChargeTransaction(username string, email string, phone string, id string, price int, name string) *coreapi.ChargeResponse {
	var coreApi = coreapi.Client{}
	coreApi.New(SERVER_KEY, midtrans.Sandbox)

	chargeReq := &coreapi.ChargeReq{
		PaymentType: coreapi.PaymentTypeGopay,
		TransactionDetails: midtrans.TransactionDetails{
			OrderID:  "MID-GO-TEST-" + generateOrderIdSuffix(),
			GrossAmt: int64(price),
		},
		CustomerDetails: &midtrans.CustomerDetails{
			FName: username,
			Email: email,
			Phone: phone,
		},
		Gopay: &coreapi.GopayDetails{
			EnableCallback: true,
		},
		Items: &[]midtrans.ItemDetails{
			{
				ID:    id,
				Price: int64(price),
				Qty:   1,
				Name:  name,
			},
		},
	}

	res, _ := coreApi.ChargeTransaction(chargeReq)

	return res
}

func StatusTransaction(transactionID string) (*coreapi.TransactionStatusResponse, *midtrans.Error) {
	var coreApi = coreapi.Client{}
	coreApi.New(SERVER_KEY, midtrans.Sandbox)

	res, err := coreApi.CheckTransaction(transactionID)

	if err != nil {
		return res, err
	}

	return res, nil
}
