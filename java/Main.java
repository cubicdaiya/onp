import onp.Diff;


public class Main {
	public static void main(String[] args) {
		Integer a[] = {1,2,3,4,5,6,7,8,9,10};
		Integer b[] = {1,2,3,4,5,0,7,8,9,10};
		Diff<Integer> diff = new Diff<Integer>(a, b);
		diff.compose();
		System.out.println("editdistance:" + diff.getEditdis());
	}
}
