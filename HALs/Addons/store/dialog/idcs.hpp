#define IDD_RscDisplayStore_DIALOG  75000
#define IDC_RscDisplayStore_LISTBOX 75010
#define IDC_RscDisplayStore_COMBO_CATEGORY 75020
#define IDC_RscDisplayStore_BUTTON_CLOSE  75030

#define IDC_RscDisplayStore_ITEM_PICTURE  75050
#define IDC_RscDisplayStore_ITEM_TEXT  75060
#define IDC_RscDisplayStore_ITEM_TEXT_DES 75061
#define IDC_RscDisplayStore_ITEM_TEXT_GROUP  75062
#define IDC_RscDisplayStore_CHECKBOX1  75070
#define IDC_RscDisplayStore_CHECKBOX2  75080
#define IDC_RscDisplayStore_CHECKBOX3  75090
#define IDC_RscDisplayStore_BUTTON_BUY  75100
#define IDC_RscDisplayStore_FUNDS  75110
#define IDC_RscDisplayStore_EDIT 75120
#define IDC_RscDisplayStore_TITLE  75130
#define IDC_RscDisplayStore_BUY_PICTURE  75140
#define IDC_RscDisplayStore_PROGRESS_LOAD  75150
#define IDC_RscDisplayStore_CHECKBOX_BUY  75160
#define IDC_RscDisplayStore_BUY_ITEM_COMBO  75170
#define IDC_RscDisplayStore_PROGRESS_NEWLOAD  75180
#define IDC_RscDisplayStore_ITEM  75190
#define IDC_RscDisplayStore_ITEM_CANEQUIP  75200
#define IDC_RscDisplayStore_ACC_GROUP  75300
#define IDC_RscDisplayStore_ACC_LISTBOX  75310
#define IDC_RscDisplayStore_ACC_COMBO  75320

#define IDC_RscDisplayStore_ITEM_STATS_PROGRESS_1  75410
#define IDC_RscDisplayStore_ITEM_STATS_PROGRESS_TEXT_1  75411
#define IDC_RscDisplayStore_ITEM_STATS_PROGRESS_2  75420
#define IDC_RscDisplayStore_ITEM_STATS_PROGRESS_TEXT_2  75421
#define IDC_RscDisplayStore_ITEM_STATS_PROGRESS_3  75430
#define IDC_RscDisplayStore_ITEM_STATS_PROGRESS_TEXT_3  75431
#define IDC_RscDisplayStore_ITEM_STATS_PROGRESS_4  75440
#define IDC_RscDisplayStore_ITEM_STATS_PROGRESS_TEXT_4  75441
#define IDC_RscDisplayStore_ITEM_STATS_PROGRESS_5  75450
#define IDC_RscDisplayStore_ITEM_STATS_PROGRESS_TEXT_5  75451


#define PGBARS [[IDC_RscDisplayStore_ITEM_STATS_PROGRESS_1, IDC_RscDisplayStore_ITEM_STATS_PROGRESS_TEXT_1],[IDC_RscDisplayStore_ITEM_STATS_PROGRESS_2, IDC_RscDisplayStore_ITEM_STATS_PROGRESS_TEXT_2],[IDC_RscDisplayStore_ITEM_STATS_PROGRESS_3, IDC_RscDisplayStore_ITEM_STATS_PROGRESS_TEXT_3],[IDC_RscDisplayStore_ITEM_STATS_PROGRESS_4, IDC_RscDisplayStore_ITEM_STATS_PROGRESS_TEXT_4],[IDC_RscDisplayStore_ITEM_STATS_PROGRESS_5, IDC_RscDisplayStore_ITEM_STATS_PROGRESS_TEXT_5]]

#define UICTRL(IDC)  ((uiNamespace getVariable ["HALs_store_display", controlNull]) controlsGroupCtrl IDC)
#define UICGCTRL(IDC) ((UICTRL(IDC_RscDisplayStore_ITEM_TEXT_GROUP)) controlsGroupCtrl IDC) 
#define CTRLSEL(IDC) (lbCurSel UICTRL(IDC))

#define UIDATA(IDC)  (UICTRL(IDC) lbData CTRLSEL(IDC))
#define UITEXT(IDC)  (UICTRL(IDC) lbText CTRLSEL(IDC))
#define UIVALUE(IDC) (UICTRL(IDC) lbValue CTRLSEL(IDC))
