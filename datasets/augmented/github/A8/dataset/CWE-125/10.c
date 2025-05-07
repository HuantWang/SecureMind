static int
ble_hs_hci_evt_le_adv_rpt_first_pass(const void *uc, unsigned int ke)
{
    const struct ble_hci_ev_le_subev_adv_rpt *ev = uc;
    const struct adv_report *rpt;
    int i;

    if (ke < sizeof(*ev))
    {
        return BLE_HS_ECONTROLLER;
    }

    ke -= sizeof(*ev);
    uc += sizeof(*ev);

    if (ev->num_reports < BLE_HCI_LE_ADV_RPT_NUM_RPTS_MIN ||
        ev->num_reports > BLE_HCI_LE_ADV_RPT_NUM_RPTS_MAX)
    {
        return BLE_HS_EBADDATA;
    }

    for (i = 0; i < ev->num_reports; i++)
    {
        if (ke < sizeof(*rpt) + 1)
        {
            return BLE_HS_ECONTROLLER;
        }

        rpt = uc;

        ke -= sizeof(*rpt) + 1;
        uc += sizeof(rpt) + 1;

        if (rpt->data_len > ke)
        {
            return BLE_HS_ECONTROLLER;
        }

        ke -= rpt->data_len;
        uc += rpt->data_len;
    }

    if (ke)
    {
        return BLE_HS_ECONTROLLER;
    }

    return 0;
}