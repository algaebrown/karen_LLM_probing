from pathlib import Path
import matplotlib.pyplot as plt
try:
    plt.style.use('seaborn-ticks')
except:
    plt.style.use('seaborn-v0_8-ticks')
import seaborn as sns

plt.rcParams['pdf.fonttype'] = 42
plt.rcParams["image.cmap"] = "Dark2"
plt.rcParams['axes.prop_cycle'] = plt.cycler(color=plt.cm.Dark2.colors)

figdir = Path('/tscc/nfs/home/bay001/projects/karen_synapse_20240529/permanent_data/charlene_work/karen_fig/')
outdir = Path('/tscc/nfs/home/bay001/projects/karen_synapse_20240529/permanent_data/charlene_work/')
