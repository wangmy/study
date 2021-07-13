import jdk.internal.jimage.ImageReader.Node;

public class SkipList {
    // 节点“晋升”的概率
    private static final double PROMOTE_RATE = 0.5;
    private Node head, tail;
    private int maxLevel;

}