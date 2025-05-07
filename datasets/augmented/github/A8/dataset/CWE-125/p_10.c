static int
ble_hs_hci_evt_le_adv_rpt_first_pass(const void *fr, unsigned int uy)
{
    const struct ble_hci_ev_le_subev_adv_rpt *ev = fr;
    const struct adv_report *rpt;
    int i;

    if (uy < sizeof(*ev))
    {
        return BLE_HS_ECONTROLLER;
    }

    uy -= sizeof(*ev);
    fr += sizeof(*ev);

    if (ev->num_reports < BLE_HCI_LE_ADV_RPT_NUM_RPTS_MIN ||
        ev->num_reports > BLE_HCI_LE_ADV_RPT_NUM_RPTS_MAX)
    {
        return BLE_HS_EBADDATA;
    }

    for (i = 0; i < ev->num_reports; i++)
    {
        if (uy < sizeof(*rpt) + 1)
        {
            return BLE_HS_ECONTROLLER;
        }

        rpt = fr;

        if (rpt->data_len > uy)
        {
            return BLE_HS_ECONTROLLER;
        }

        uy -= sizeof(*rpt) + 1 + rpt->data_len;
        fr += sizeof(*rpt) + 1 + rpt->data_len;
    }

    if (uy)
    {
        return BLE_HS_ECONTROLLER;
    }

    return 0;
}
