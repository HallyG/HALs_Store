#define UICTRL(IDC)  ((uiNamespace getVariable ["HALs_store_display", controlNull]) controlsGroupCtrl IDC) 
#define CTRLSEL(IDC) (lbCurSel UICTRL(IDC))
#define UIDATA(IDC)  (UICTRL(IDC) lbData CTRLSEL(IDC))
#define UITEXT(IDC)  (UICTRL(IDC) lbText CTRLSEL(IDC))
#define UIVALUE(IDC) (UICTRL(IDC) lbValue CTRLSEL(IDC))