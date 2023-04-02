import { FeatureColorInput, Feature, FeatureChoiced, FeatureDropdownInput } from './base';

export const eye_color: Feature<string> = {
  name: 'Eye color',
  component: FeatureColorInput,
};

export const facial_hair_color: Feature<string> = {
  name: 'Facial hair color',
  component: FeatureColorInput,
};

export const facial_hair_gradient: FeatureChoiced = {
  name: 'Facial hair gradient',
  component: FeatureDropdownInput,
};

export const facial_hair_gradient_color: Feature<string> = {
  name: 'Facial hair gradient color',
  component: FeatureColorInput,
};

export const hair_color: Feature<string> = {
  name: 'Hair color',
  component: FeatureColorInput,
};

export const hair_gradient: FeatureChoiced = {
  name: 'Hair gradient',
  component: FeatureDropdownInput,
};

export const hair_gradient_color: Feature<string> = {
  name: 'Hair gradient color',
  component: FeatureColorInput,
};

export const feature_human_ears: FeatureChoiced = {
  name: 'Ears',
  component: FeatureDropdownInput,
};

export const feature_human_tail: FeatureChoiced = {
  name: 'Tail',
  component: FeatureDropdownInput,
};

export const feature_beef_trauma: Feature<string> = {
  name: 'Beefman Trauma',
  component: FeatureDropdownInput,
};

export const feature_lizard_legs: FeatureChoiced = {
  name: 'Legs',
  component: FeatureDropdownInput,
};

export const feature_lizard_spines: FeatureChoiced = {
  name: 'Spines',
  component: FeatureDropdownInput,
};

export const feature_lizard_tail: FeatureChoiced = {
  name: 'Tail',
  component: FeatureDropdownInput,
};

export const feature_mcolor: Feature<string> = {
  name: 'Mutant color',
  component: FeatureColorInput,
};

export const underwear_color: Feature<string> = {
  name: 'Underwear color',
  component: FeatureColorInput,
};

export const feature_vampire_status: Feature<string> = {
  name: 'Vampire status',
  component: FeatureDropdownInput,
};

export const heterochromatic: Feature<string> = {
  name: 'Heterochromatic (Right Eye) color',
  component: FeatureColorInput,
};

export const ipc_screen_toggle: FeatureToggle = {
  name: 'IPC Screen',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_ipc_screen: Feature<string> = {
  name: 'IPC Screen Selection',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureDropdownInput,
};

export const ipc_screen_color: Feature<string[]> = {
  name: 'IPC Screen Colors',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const ipc_screen_emissive: Feature<boolean[]> = {
  name: 'IPC Screen Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const ipc_antenna_toggle: FeatureToggle = {
  name: 'IPC Antenna',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_ipc_antenna: Feature<string> = {
  name: 'IPC Antenna Selection',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureDropdownInput,
};

export const ipc_antenna_color: Feature<string[]> = {
  name: 'IPC Antenna Colors',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const ipc_antenna_emissive: Feature<boolean[]> = {
  name: 'IPC Antenna Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const ipc_chassis_toggle: FeatureToggle = {
  name: 'IPC Chassis',
  description: "Allows customization of an IPC's chassis! Only works for IPCs.",
  component: CheckboxInput,
};

export const feature_ipc_chassis: Feature<string> = {
  name: 'IPC Chassis Selection',
  description: "Allows customization of an IPC's chassis! Only works for IPCs.",
  component: FeatureDropdownInput,
};

export const ipc_chassis_color: Feature<string[]> = {
  name: 'IPC Chassis Colors',
  description:
    "Allows customization of an IPC's chassis! Only works for IPCs, for chassis that support greyscale coloring.",
  component: FeatureTriColorInput,
};

export const ipc_head_toggle: FeatureToggle = {
  name: 'IPC Head',
  description: "Allows customization of an IPC's head! Only works for IPCs.",
  component: CheckboxInput,
};

export const feature_ipc_head: Feature<string> = {
  name: 'IPC Head Selection',
  description: "Allows customization of an IPC's head! Only works for IPCs.",
  component: FeatureDropdownInput,
};

export const ipc_head_color: Feature<string[]> = {
  name: 'IPC Head Colors',
  description:
    "Allows customization of an IPC's head! Only works for IPCs, for heads that support greyscale coloring.",
  component: FeatureTriColorInput,
};
